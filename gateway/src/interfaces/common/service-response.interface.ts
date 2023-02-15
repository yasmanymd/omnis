export interface IServiceResponse<Type> {
  status: number;
  message: string;
  data: Type | null;
  errors: { [key: string]: any };
}